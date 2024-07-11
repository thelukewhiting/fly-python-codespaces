FROM mcr.microsoft.com/vscode/devcontainers/python:3.9

# Install Poetry
RUN pip install poetry

# Configure Poetry
RUN poetry config virtualenvs.in-project true

# Install additional tools
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends git curl

# Install Fly CLI
RUN curl -L https://fly.io/install.sh | sh

# Add Fly to PATH
ENV PATH="/root/.fly/bin:$PATH"

# Make sure the entrypoint script can use the Fly CLI
RUN echo 'export PATH="/root/.fly/bin:$PATH"' >> /home/vscode/.bashrc

# Set the working directory
WORKDIR /workspaces/fly-python-codespaces

# Copy pyproject.toml and poetry.lock (if it exists)
COPY . .

# Install dependencies
RUN if [ -f "pyproject.toml" ]; then poetry install --no-root; fi

# Install the project
RUN if [ -f "pyproject.toml" ]; then poetry install; fi