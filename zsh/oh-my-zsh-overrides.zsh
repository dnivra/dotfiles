# Set of overrides for oh-my-zsh functions

# Override upstream git_remote_status
git_remote_status() {
    remote=${$(git rev-parse --verify origin/$(current_branch) --symbolic-full-name 2>/dev/null)/refs\/remotes\/}
    if [[ -n ${remote} ]] ; then
        ahead=$(git rev-list origin/$(current_branch)..HEAD 2>/dev/null | wc -l)
        behind=$(git rev-list HEAD..origin/$(current_branch) 2>/dev/null | wc -l)

        if [ $ahead -eq 0 ] && [ $behind -gt 0 ]
        then
            echo "$ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE$behind"
        elif [ $ahead -gt 0 ] && [ $behind -eq 0 ]
        then
            echo "$ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE$ahead"
        elif [ $ahead -gt 0 ] && [ $behind -gt 0 ]
        then
            echo "$ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE"
        fi
    fi
}

# Use apt-get by default
apt_pref='apt-get'
