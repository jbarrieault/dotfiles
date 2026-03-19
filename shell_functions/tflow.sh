tflow() {
  local dir=""
  local name=""
  local attach=false

  # Parse args
  while [[ $# -gt 0 ]]; do
    case "$1" in
    -h | --help)
      echo "Usage: tflow [-d <directory>] [-n <session-name>] [-a] [-h]"
      echo ""
      echo "Create a tmux session with 3 windows: shell, claude, nvim."
      echo ""
      echo "Options:"
      echo "  -d <directory>      Set the working directory (default: current directory)"
      echo "  -n <session-name>   Set the tmux session name (default: last part of directory path)"
      echo "  -a                  Attach to the session after creating it"
      echo "  -h, --help          Show this help message"
      echo ""
      echo "If both -d and -n are provided, -n sets the session name and -d sets the"
      echo "working directory."
      return 0
      ;;
    -d)
      if [[ -z "$2" || "$2" == -* ]]; then
        echo "Error: -d requires a directory argument" >&2
        return 1
      fi
      dir="$2"
      shift 2
      ;;
    -n)
      if [[ -z "$2" || "$2" == -* ]]; then
        echo "Error: -n requires a name argument" >&2
        return 1
      fi
      name="$2"
      shift 2
      ;;
    -a)
      attach=true
      shift
      ;;
    *)
      echo "Unknown option: $1. Run 'tflow -h' for usage." >&2
      return 1
      ;;
    esac
  done

  # Resolve directory
  if [[ -z "$dir" ]]; then
    dir="$PWD"
  else
    dir="$(cd "$dir" 2>/dev/null && pwd)"
    if [[ -z "$dir" ]]; then
      echo "Error: directory does not exist" >&2
      return 1
    fi
  fi

  # Resolve session name
  if [[ -z "$name" ]]; then
    name="${dir##*/}"
  fi

  # Check for existing session
  if tmux has-session -t "$name" 2>/dev/null; then
    echo "Error: tmux session '$name' already exists" >&2
    return 1
  fi

  # Create session with first window named 'shell'
  tmux new-session -d -s "$name" -c "$dir" -n "shell"
  tmux new-window -t "$name" -c "$dir" -n "claude"
  tmux send-keys -t "${name}:claude" "claude" C-m
  tmux new-window -t "$name" -c "$dir" -n "nvim"
  tmux send-keys -t "${name}:nvim" "nvim ." C-m

  # Select the first window
  tmux select-window -t "${name}:shell"

  local bold="\033[1m"
  local dim="\033[2m"
  local green="\033[32m"
  local cyan="\033[36m"
  local yellow="\033[33m"
  local magenta="\033[35m"
  local reset="\033[0m"

  # Calculate the longest visible line width (all content lines have an
  # 11-char prefix: 2-space indent + label + padding to column 11)
  local windows_text="shell · claude · nvim"
  local max_width=11
  local w
  for w in ${#name} ${#windows_text}; do
    (( w + 11 > max_width )) && max_width=$(( w + 11 ))
  done
  if [[ "$name" != "${dir##*/}" ]]; then
    (( ${#dir} + 11 > max_width )) && max_width=$(( ${#dir} + 11 ))
  fi

  # Build the OK line: 2-space indent + dashes + " OK " + dashes = max_width
  local dash_total=$(( max_width - 2 - 4 ))  # subtract indent and " OK "
  local left_n=$(( dash_total / 2 ))
  local right_n=$(( dash_total - left_n ))
  local left_dashes=""
  local right_dashes=""
  local i
  for (( i = 0; i < left_n; i++ )); do left_dashes+="─"; done
  for (( i = 0; i < right_n; i++ )); do right_dashes+="─"; done

  echo ""
  echo -e "  ${dim}${left_dashes}${reset} ${green}${bold}OK${reset} ${dim}${right_dashes}${reset}"
  echo ""
  echo -e "  ${dim}session${reset}  ${bold}${yellow}${name}${reset}"
  if [[ "$name" != "${dir##*/}" ]]; then
    echo -e "  ${dim}dir${reset}      ${dir}"
  fi
  echo -e "  ${dim}windows${reset}  ${cyan}shell${reset} ${dim}·${reset} ${magenta}claude${reset} ${dim}·${reset} ${green}nvim${reset}"
  echo ""

  # Attach if requested
  if [[ "$attach" == true ]]; then
    tmux attach-session -t "$name"
  fi
}
