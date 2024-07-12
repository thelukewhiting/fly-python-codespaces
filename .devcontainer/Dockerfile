FROM mcr.microsoft.com/vscode/devcontainers/python:3.9

# Install Poetry
RUN pip install poetry==1.8.3

# Configure Poetry
RUN poetry config virtualenvs.in-project true

# Install additional tools
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends git curl sudo

# Set the working directory
WORKDIR /workspaces/fly-python-codespaces

# Copy pyproject.toml and poetry.lock (if it exists)
COPY pyproject.toml poetry.lock* ./

# Install dependencies and create virtual environment
RUN poetry install --no-root

# Copy the rest of the code
COPY . .

# Install the project
RUN poetry install

# Install Fly CLI for all users
RUN curl -L https://fly.io/install.sh | sudo sh

# Add Fly to PATH for all users
ENV FLYCTL_INSTALL="/usr/local/lib/flyctl"
ENV PATH="$FLYCTL_INSTALL/bin:$PATH"

# Make sure the Fly CLI is available in interactive shells
RUN echo 'export FLYCTL_INSTALL="/usr/local/lib/flyctl"' >> /etc/bash.bashrc && \
    echo 'export PATH="$FLYCTL_INSTALL/bin:$PATH"' >> /etc/bash.bashrc

# Ensure the .venv directory is owned by vscode user
RUN chown -R vscode:vscode /workspaces/fly-python-codespaces/.venv

# Give vscode user sudo privileges
RUN echo "vscode ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/vscode

# Switch to the vscode user
USER vscode

# Activate virtual environment
ENV VIRTUAL_ENV=/workspaces/fly-python-codespaces/.venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"