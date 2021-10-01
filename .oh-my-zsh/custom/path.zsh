# GNU utils path overrides as default CLI tools
# Causes issues with c++ compilation in arm64 mac.
#if type brew &>/dev/null; then
#  HOMEBREW_PREFIX=$(brew --prefix)
#  for d in ${HOMEBREW_PREFIX}/opt/*/libexec/gnubin; do export PATH=$d:$PATH; done
#fi
