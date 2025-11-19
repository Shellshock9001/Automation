# Crash Log Model Evaluation Harness

This repository contains a **real-world crash log evaluation harness** built around:

- A **single crash log file** (drag-and-drop onto the terminal)
- A **static dataset of gold labels** describing what a good analysis should contain
- An **OpenAI-based crash analysis engine** that:
  - Reads the raw crash log
  - Produces a structured JSON analysis
  - Scores that analysis across multiple categories with **separate scoring logic**
  - Outputs **color-coded CLI summaries** and **GitHub-ready reports**

This is designed to look and behave like something you would actually use inside a
production SRE / security / intel / infra org, not a toy “demo script.”

---

## Features

- **Drag-and-drop log evaluation**
  - CLI takes **one crash log file path** as input.
  - You drag the `.log` file into the terminal, hit Enter, done.
- **Static, curated gold dataset**
  - `data/crash_eval_dataset.json` stores **gold labels** (root-cause markers, component,
    severity, fix-plan markers, test-focus areas).
  - The dataset does **not** reference log paths. It’s reusable across many logs.
- **OpenAI-powered structured analysis**
  - Uses the **Responses API** with a **strict JSON schema**.
  - Forces the model to output:
    - `root_cause`
    - `component`
    - `severity`
    - `fix_plan`
    - `tests_to_add`
- **Per-category scoring logic (no lumping)**
  - `root_cause` scored on keyword coverage and specificity.
  - `component` scored on exact ID, alt names, and generic decoder area.
  - `severity` scored by SEV distance (`SEV-1`..`SEV-4`).
  - `fix_plan` scored across 4 dimensions + gold keyword bonus.
  - `tests_to_add` scored across 4 dimensions + specificity bonus.
- **Rich outputs**
  - **Color-coded** terminal summary per case.
  - **Machine-readable JSON** report.
  - **Human-readable Markdown** report, ready for GitHub / review docs.
  - Report filenames are **derived from the crash log name**.

---

## Repository Layout

Recommended layout:

```text
sepalai/
  crash_eval.py
  data/
    crash_eval_dataset.json
  reports/
    (generated) sigint-ingestd_crash_2025-11-19T03-12-47Z_results.json
    (generated) sigint-ingestd_crash_2025-11-19T03-12-47Z_results.md
  sigint-ingestd_crash_2025-11-19T03-12-47Z.log
