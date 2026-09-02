#!/usr/bin/env bash
# Eject the focused tab into a new workspace, preserving its split layout.
#
# herdr moves panes across workspaces but not tabs, so this replays the tab's
# guillotine layout: the first pane creates the workspace, each later pane
# splits the cell it belongs to.
set -euo pipefail

# Recovers the binary split tree from pane rectangles, then emits the move
# order as TSV: mover, direction, ratio, anchor.
read -r -d '' PLAN <<'JQ' || true
def build:
  . as $r
  | if ($r|length) == 1 then {pane: $r[0].pane_id}
    else
      ( first(
          (["x","width","right"], ["y","height","down"]) as [$axis,$size,$dir]
          | ([$r[] | .rect[$axis] + .rect[$size]] | unique | .[0:-1][]) as $cut
          | [$r[] | select(.rect[$axis] + .rect[$size] <= $cut)] as $a
          | [$r[] | select(.rect[$axis] >= $cut)] as $b
          | select(($a|length) > 0 and ($b|length) > 0
                   and (($a|length) + ($b|length)) == ($r|length))
          | ([$r[] | .rect[$axis]] | min) as $origin
          | ([$r[] | .rect[$axis] + .rect[$size]] | max) as $span
          | { direction: $dir,
              ratio: ((($cut - $origin) / ($span - $origin)) * 10000 | round / 10000),
              first: ($a | build), second: ($b | build) }
        )
        # Not a clean guillotine layout; degrade to a flat row rather than bail.
        // { direction: "right", ratio: 0.5,
             first: ($r[0:1] | build), second: ($r[1:] | build) } )
    end;

def firstpane: if has("pane") then .pane else .first | firstpane end;

def plan($anchor):
  if has("pane") then empty
  else
    (.second | firstpane) as $mover
    | [$mover, .direction, (.ratio|tostring), $anchor],
      (.first  | plan($anchor)),
      (.second | plan($mover))
  end;

(.panes | build) as $tree
| ($tree | firstpane) as $root
| ["ROOT", $root], ($tree | plan($root))
| @tsv
JQ

# Defaults to the focused pane; takes a pane id for testing.
target=(--current)
[ $# -gt 0 ] && target=(--pane "$1")

layout=$(herdr pane layout "${target[@]}" | jq -c '.result.layout')
focused=$(jq -r '.focused_pane_id' <<<"$layout")
workspace=$(jq -r '.workspace_id' <<<"$layout")
tab=$(jq -r '.tab_id' <<<"$layout")
label=$(herdr tab list --workspace "$workspace" |
  jq -r --arg t "$tab" '.result.tabs[] | select(.tab_id==$t) | .label // ""')

steps=$(jq -r "$PLAN" <<<"$layout")
root=$(awk -F'\t' '$1=="ROOT" {print $2}' <<<"$steps")

# Focus rides along on whichever move carries the originally focused pane.
flag() { if [ "$1" = "$focused" ]; then echo --focus; else echo --no-focus; fi; }

create=(pane move "$root" --new-workspace "$(flag "$root")")
[ -n "$label" ] && create+=(--label "$label" --tab-label "$label")
new_tab=$(herdr "${create[@]}" | jq -r '.result.move_result.created_tab.tab_id')

while IFS=$'\t' read -r mover direction ratio anchor; do
  [ "$mover" = "ROOT" ] || [ -z "$mover" ] && continue
  herdr pane move "$mover" --tab "$new_tab" --split "$direction" \
    --target-pane "$anchor" --ratio "$ratio" "$(flag "$mover")" >/dev/null
done <<<"$steps"
