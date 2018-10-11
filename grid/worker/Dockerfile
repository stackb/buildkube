FROM gcr.io/cloud-marketplace/google/rbe-ubuntu16-04@sha256:9bd8ba020af33edb5f11eff0af2f63b3bcb168cd6566d7b27c6685e717787928

# Upgrade python modules
RUN python3 -m pip install --upgrade setuptools pip

# Use /app as the current working directory
WORKDIR /app

# Copy the repo contents (source, config files, etc) in the WORKDIR
COPY . .

# Install BuildGrid
RUN pip install --user --editable .
