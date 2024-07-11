FROM mcr.microsoft.com/vscode/devcontainers/python:3.9

# Install Poetry
RUN pip install poetry

# Configure Poetry
RUN poetry config virtualenvs.in-project true

# Install dependencies
WORKDIR /workspace
COPY pyproject.toml ./
RUN poetry install

# Install additional tools
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends git curl

# Install Fly CLI
RUN curl -L https://fly.io/install.sh | sh

# Add Fly to PATH
ENV PATH="/root/.fly/bin:$PATH"

# Make sure the entrypoint script can use the Fly CLI
RUN echo 'export PATH="/root/.fly/bin:$PATH"' >> /home/vscode/.bashrc