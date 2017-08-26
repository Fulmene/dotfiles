if [[ -n "$NVIM_LISTEN_ADDRESS" ]] && which nvr >&/dev/null; then
    alias nvim='nvr -cc split --remote'
fi

