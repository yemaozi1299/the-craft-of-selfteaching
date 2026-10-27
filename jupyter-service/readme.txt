cd C:\ooooo\xiaolai\自学是一门手艺\jupyter-service
powershell -ExecutionPolicy Bypass -File .\stop-jupyter-lab.ps1            # 先停掉手动开的那个
powershell -ExecutionPolicy Bypass -File .\install-startup.ps1 -Start      # 装自启 + 立刻启动