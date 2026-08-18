# LIBERO SmolVLA Notebook Docker

Notebook を実行するための最小構成です。

## ファイル

| パス | 役割 |
| --- | --- |
| `Dockerfile` / `docker-compose.yml` | GPU 付き JupyterLab 環境 |
| `docker_support/google_colab_shim/` | Docker 上で `google.colab` 呼び出しを置き換える補助コード |
| `docker_support/run_notebook.sh` | notebook を先頭から実行する任意のコマンド |

## Notebook の配置

実行対象の `.ipynb` ファイルは、このリポジトリのルートに置いてください。Docker 実行時はルート全体を `/workspace` にマウントします。

## 実行方法

前提: Docker と NVIDIA GPU を利用できる環境。

```powershell
docker compose build
docker compose up notebook
```

ブラウザで以下を開き、対象の `.ipynb` を上から順に実行します。

```text
http://localhost:8888/lab?token=notebook
```

コマンドだけで実行する場合:

```powershell
docker compose run --rm notebook bash docker_support/run_notebook.sh
```

実行結果は `runs/` に作成されます。

## 参考

| 項目 | 参照先 |
| --- | --- |
| LeRobot | https://github.com/huggingface/lerobot |
| LIBERO-plus | https://github.com/sylvestf/LIBERO-plus |
| SmolVLA base model | https://huggingface.co/lerobot/smolvla_libero_plus |
| LIBERO-plus dataset | https://huggingface.co/datasets/lerobot/libero_plus |
| SmolVLM2 backbone | https://huggingface.co/HuggingFaceTB/SmolVLM2-500M-Video-Instruct |
