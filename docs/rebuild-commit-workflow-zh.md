# 重新编译特定提交的 GitHub Action 工作流

本仓库包含一个 GitHub Action 工作流，允许您重新编译 Mohist 服务器的任何特定提交。

## 如何使用

1. **导航到 GitHub 仓库的 Actions 选项卡**
2. **从工作流列表中选择 "Rebuild Specific Commit"**
3. **点击 "Run workflow" 按钮**
4. **填写参数:**
   - **Commit SHA**: 输入您想要重新编译的提交哈希 (例如: `95dd6ec`)
   - **Artifact name suffix** (可选): 添加自定义后缀以区分您的构建
   - **Fetch from upstream**: 是否从主 MohistMC 仓库获取

5. **点击 "Run workflow"** 开始构建

## 使用示例

### 重新编译 PlayerPickItemEvent 修复
要重新编译提交 `95dd6ec`（添加 PlayerPickItemEvent 修复）:

```
Commit SHA: 95dd6ec
Artifact name suffix: player-pick-fix
```

这将创建一个名为: `Mohist-1.20.1-server-95dd6ec-player-pick-fix` 的构建产物

### 测试历史构建
您可以重新编译任何历史提交来测试兼容性或特定功能:

```
Commit SHA: abc123d
Artifact name suffix: test-build
```

## 构建过程

工作流执行以下步骤:

1. **检出**: 下载包含完整历史的仓库
2. **获取上游**: 可选地从主 MohistMC 仓库获取
3. **提交检出**: 切换到指定的提交
4. **Java 设置**: 配置 JDK 17
5. **Gradle 设置**: 运行 `./gradlew setup packageLibraries`
6. **构建**: 运行 `./gradlew mohistJar`
7. **上传**: 创建包含构建的服务器 jar 的可下载构建产物

## 故障排除

### 常见问题

- **找不到提交**: 确保提交存在，尝试启用 "Fetch from upstream"
- **构建失败**: 一些较旧的提交可能存在依赖问题或需要不同的构建配置
- **网络超时**: 工作流包含针对网络相关故障的重试逻辑

### 获取构建日志

如果构建失败，请在 Actions 选项卡中查看工作流运行日志以获取详细的错误消息和故障排除信息。

## 构建产物下载

工作流成功完成后:

1. 转到工作流运行页面
2. 向下滚动到 "Artifacts" 部分
3. 点击您的构建产物以下载构建的服务器 jar

下载的 jar 可以通过运行以下命令用作 Mohist 服务器:
```bash
java -jar mohist-1.20.1-[commit]-server.jar
```

## 专门针对提交 95dd6ec

提交 `95dd6ec` 添加了 PlayerPickItemEvent 修复 (#3595)。要重新编译此特定提交:

1. 转到 Actions → "Rebuild Specific Commit"
2. 输入提交 SHA: `95dd6ec`
3. 运行工作流
4. 下载生成的 `Mohist-1.20.1-server-95dd6ec.jar` 文件

这个构建将包含 PlayerPickItemEvent 的修复，允许您测试或使用此特定功能。