# Disable Windows Recall Feature

> [!WARNING]
> - <ins>Administrator</ins> Terminal required!

## Informational
- Windows Recall is an AI-powered search tool for Copilot+ PCs designed to act as a "photographic memory" for your computer activity. 

- <ins>Captures Snapshots:</ins> It takes screenshots of your active window every few seconds.

- <ins>AI Analysis:</ins> On-device AI analyzes these snapshots using optical character recognition (OCR) to index text and images.

- <ins>Searchable Timeline:</ins> Users can search for past activities (websites, documents, or apps) using natural language or by scrolling through a visual timeline.

- <ins>Actionable Content:</ins> A "Click to Do" feature allows you to interact with old snapshots, such as copying text or searching for recognized objects. 


## Commands
### Check status first:
```powershell
DISM /Online /Get-FeatureInfo /FeatureName:Recall
```

### Uninstall the feature completely:
> [!CAUTION]
> - <ins>Reboot required!</ins>
```powershell
DISM /Online /Disable-Feature /FeatureName:Recall /Remove
```
