FROM nvidia/cuda:12.8.1-cudnn-devel-ubuntu24.04

ENV DEBIAN_FRONTEND=noninteractive \
    VIRTUAL_ENV=/opt/venv \
    PATH=/opt/venv/bin:$PATH \
    PIP_BREAK_SYSTEM_PACKAGES=1 \
    PIP_NO_CACHE_DIR=1 \
    PYTHONUNBUFFERED=1 \
    TOKENIZERS_PARALLELISM=false \
    HF_HUB_DISABLE_IMPLICIT_TOKEN=1 \
    HF_HUB_DISABLE_TELEMETRY=1 \
    HF_HUB_DISABLE_PROGRESS_BARS=1 \
    HF_DATASETS_DISABLE_PROGRESS_BARS=1 \
    MUJOCO_GL=egl \
    PYOPENGL_PLATFORM=egl \
    PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True \
    PYTHONPATH=/opt/google_colab_shim

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    ffmpeg \
    git \
    git-lfs \
    libexpat1 \
    libegl1 \
    libfontconfig1-dev \
    libgl1 \
    libglib2.0-0 \
    libmagickwand-dev \
    libsm6 \
    libxext6 \
    python3-pip \
    python3.12 \
    python3.12-dev \
    python3.12-venv \
    sudo \
    unzip \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN python3.12 -m venv /opt/venv \
    && python -m pip install --upgrade pip setuptools wheel

ARG TORCH_INDEX_URL=https://download.pytorch.org/whl/cu128
RUN python -m pip install \
    --index-url "${TORCH_INDEX_URL}" \
    --extra-index-url https://pypi.org/simple \
    "torch>=2.7,<2.12" \
    "torchvision>=0.22,<0.27"

RUN python -m pip install \
    ipykernel \
    ipywidgets \
    jupyter \
    jupyterlab \
    matplotlib \
    nbconvert \
    notebook \
    pandas \
    plotly \
    seaborn \
    && python -m ipykernel install --sys-prefix --name python3 --display-name ".venv"

COPY docker_support/google_colab_shim /opt/google_colab_shim

RUN mkdir -p \
    /workspace \
    /content/workdir \
    /content/drive/MyDrive/smolvla_task

WORKDIR /workspace

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--ServerApp.token=notebook", "--ServerApp.password="]
