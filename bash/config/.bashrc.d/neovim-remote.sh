if [[ -n "$NVIM_LISTEN_ADDRESS" ]] && which nvr >&/dev/null; then
    alias nvim='nvr --remote'
fi

