FROM mcr.microsoft.com/vscode/devcontainers/python:3.9

# Install Poetry
RUN pip install poetry==1.8.3

# Configure Poetry
RUN poetry config virtualenvs.in-project true

# Install additional tools and ensure curl is installed
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends git curl ca-certificates sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /workspaces/fly-python-codespaces

# Copy pyproject.toml and poetry.lock (if it exists)
COPY pyproject.toml poetry.lock* ./

# Copy the project files
COPY . .

# Copy the installation script to the .devcontainer directory
COPY .devcontainer/install_flyctl.sh .devcontainer/install_flyctl.sh
RUN chmod +x .devcontainer/install_flyctl.sh

# Install dependencies and the project
RUN poetry install --no-root

# Ensure the .venv directory is owned by vscode user
RUN chown -R vscode:vscode /workspaces/fly-python-codespaces

# Switch to the vscode user
USER vscode

# Activate virtual environment
ENV VIRTUAL_ENV=/workspaces/fly-python-codespaces/.venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
