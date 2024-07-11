FROM mcr.microsoft.com/vscode/devcontainers/python:3.9

# Install Poetry
RUN pip install poetry==1.8.3

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
COPY pyproject.toml poetry.lock* ./

# Install dependencies and create virtual environment
RUN poetry install --no-root

# Copy the rest of the code
COPY . .

# Install the project
RUN poetry install

# Activate virtual environment
ENV VIRTUAL_ENV=/workspaces/fly-python-codespaces/.venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Ensure Fly CLI is available to all users
RUN ln -s /root/.fly/bin/fly /usr/local/bin/fly