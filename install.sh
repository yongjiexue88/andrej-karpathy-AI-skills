#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
block_start='<!-- andrej-karpathy-output-skills:start -->'
block_end='<!-- andrej-karpathy-output-skills:end -->'

usage() {
  cat <<'USAGE'
Usage:
  bash install.sh [codex|claude|cursor] [--dest SKILLS_DIRECTORY]
  bash install.sh project PROJECT_DIRECTORY
  bash install.sh --help

With no arguments, install the karpathy-output-guidelines skill for Codex.
Project mode adds all eight rules to AGENTS.md and CLAUDE.md.
Existing project instructions are preserved. Re-running updates the same block.
Changed files are backed up beside the destination before installation.
Requires Bash and standard shell utilities; no package installation is needed.
USAGE
}

fail() {
  printf 'Error: %s\n' "$*" >&2
  exit 1
}

install_file() {
  local source_file="$1" destination="$2" backup_file
  if [[ -e "$destination" && ! -f "$destination" ]]; then
    fail "Destination is not a regular file: $destination"
  fi
  if [[ -f "$destination" ]] && cmp -s "$source_file" "$destination"; then
    printf 'Unchanged: %s\n' "$destination"
    return
  fi
  mkdir -p -- "$(dirname -- "$destination")"
  if [[ -f "$destination" ]]; then
    backup_file="$(mktemp "$destination.backup.XXXXXX")"
    cp -p -- "$destination" "$backup_file"
    printf 'Backup: %s\n' "$backup_file"
  fi
  cp -- "$source_file" "$destination"
  printf 'Installed: %s\n' "$destination"
}

mode=codex
if [[ $# -gt 0 && "$1" != --dest ]]; then
  mode="$1"
  shift
fi

case "$mode" in
  -h|--help)
    usage
    exit 0
    ;;
  codex) skills_dir="${CODEX_HOME:-$HOME/.codex}/skills" ;;
  claude) skills_dir="$HOME/.claude/skills" ;;
  cursor) skills_dir="$HOME/.cursor/skills" ;;
  project)
    [[ $# -eq 1 && -n "$1" ]] || fail 'Project mode requires one project directory.'
    project_dir="$1"
    [[ -d "$project_dir" ]] || fail "Project directory does not exist: $project_dir"
    staged_file="$(mktemp "${TMPDIR:-/tmp}/karpathy-output-rules.XXXXXX")"
    trap 'rm -f -- "$staged_file"' EXIT

    for name in AGENTS.md CLAUDE.md; do
      source_file="$repo_dir/$name"
      destination="$project_dir/$name"
      input_file=/dev/null
      if [[ -e "$destination" ]]; then
        [[ -f "$destination" ]] || fail "Destination is not a regular file: $destination"
        if cmp -s "$source_file" "$destination"; then
          printf 'Unchanged: %s\n' "$destination"
          continue
        fi
        input_file="$destination"
      fi

      # Replace only this project's managed block, keeping other instructions.
      if ! awk -v source="$source_file" -v start="$block_start" -v end="$block_end" '
        function emit_block(line) {
          print start
          while ((getline line < source) > 0) print line
          close(source)
          print end
        }
        $0 == start {
          if (in_block || seen) { invalid = 1; exit }
          emit_block()
          in_block = 1
          seen = 1
          next
        }
        $0 == end {
          if (!in_block) { invalid = 1; exit }
          in_block = 0
          next
        }
        !in_block { print }
        END {
          if (invalid || in_block) exit 1
          if (!seen) {
            if (NR > 0) print ""
            emit_block()
          }
        }
      ' "$input_file" > "$staged_file"; then
        fail "Incomplete or duplicate managed block in $destination. File left unchanged."
      fi
      install_file "$staged_file" "$destination"
    done
    printf 'Project instructions are ready. Start a new agent session in this project.\n'
    exit 0
    ;;
  *)
    usage >&2
    fail "Unknown target: $mode"
    ;;
esac

if [[ $# -gt 0 ]]; then
  [[ $# -eq 2 && "$1" == --dest && -n "$2" ]] || fail 'Expected --dest SKILLS_DIRECTORY.'
  skills_dir="$2"
fi

skill_name=karpathy-output-guidelines
install_file "$repo_dir/skills/$skill_name/SKILL.md" "$skills_dir/$skill_name/SKILL.md"
printf 'Skill is ready for %s. Start a new agent session to load it.\n' "$mode"
