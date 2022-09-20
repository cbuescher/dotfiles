#
# Main prompt
#
local host_name="%{$fg[green]%}%m"
local path_string="%{$fg[yellow]%}%~%{$reset_color%}"
local prompt_string="$ "

# Make prompt_string red if the previous command failed.
local return_status="%(?:$prompt_string:%{$fg[red]%}$prompt_string%{$reset_color%})"

PROMPT='${host_name}:${path_string}$(git_super_status)${return_status}'

# oh-my-zsh $(git_prompt_info) puts 'dirty' behind branch
#git_custom_prompt() {
#  # branch name (.oh-my-zsh/plugins/git/git.plugin.zsh)
#  local branch=$(current_branch)
#  if [ -n "$branch" ]; then
#    # parse_git_dirty echoes PROMPT_DIRTY or PROMPT_CLEAN (.oh-my-zsh/lib/git.zsh)
#    echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$branch$ZSH_THEME_GIT_PROMPT_SUFFIX"
#  fi
#}

#RPROMPT='$(git_custom_prompt) %*'
RPROMPT='%*'
