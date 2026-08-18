from pathlib import Path


def download(filename, *args, **kwargs):
    """Local replacement for google.colab.files.download inside Docker."""
    path = Path(filename)
    shown = path.resolve() if path.exists() else path
    print(f"[google.colab shim] download skipped; file is available at: {shown}")
    return None

