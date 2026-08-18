from pathlib import Path


def mount(mountpoint="/content/drive", *args, **kwargs):
    """Local replacement for google.colab.drive.mount inside Docker."""
    root = Path(mountpoint)
    backup_dir = root / "MyDrive" / "smolvla_task"
    backup_dir.mkdir(parents=True, exist_ok=True)
    print(f"[google.colab shim] using local directory: {root}")
    return None

