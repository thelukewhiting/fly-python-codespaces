FROM mcr.microsoft.com/vscode/devcontainers/python:3.9

# Install Poetry
RUN pip install poetry==1.8.3

# Configure Poetry
RUN poetry config virtualenvs.in-project true

# Install additional tools
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends git curl ca-certificates

# Set the working directory
WORKDIR /workspaces/fly-python-codespaces

# Copy pyproject.toml and poetry.lock (if it exists)
COPY pyproject.toml poetry.lock* ./

# Copy the project files
COPY . .

# Install dependencies and the project
RUN poetry install

# Ensure the .venv directory is owned by vscode user
RUN chown -R vscode:vscode /workspaces/fly-python-codespaces

# Switch to the vscode user
USER vscode

# Activate virtual environment
ENV VIRTUAL_ENV=/workspaces/fly-python-codespaces/.venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Copy the installation script
COPY install_flyctl.sh /tmp/scripts/install_flyctl.sh
RUN chmod +x /tmp/scripts/install_flyctl.s