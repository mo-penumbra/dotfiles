export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PYTHONPATH="/usr/local/lib/python3.12/dist-packages:$PYTHONPATH"
source /etc/profile.d/rust.sh 2>/dev/null || true

if [ -f "/opt/jupyter/kernels/datascience/bin/activate" ]; then
  source "/opt/jupyter/kernels/datascience/bin/activate"
fi
# Platform Python configuration
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PYTHONPATH="/usr/local/lib/python3.12/dist-packages:$PYTHONPATH"
source /etc/profile.d/rust.sh 2>/dev/null || true

# Activate data science kernel virtual environment
if [ -f "/opt/jupyter/kernels/datascience/bin/activate" ]; then
  source "/opt/jupyter/kernels/datascience/bin/activate"
fi

. "$HOME/.local/bin/env"
