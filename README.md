# ICN DevOps demo: Terraform + Ansible + GitHub Actions on Azure

Seminar project for **Infrastructure and Cloud Computing (ICN), 2026/2027**, Theme B: DevOps and CI/CD.
Group G7, Samuel Silva.

In Lab 3 we created a virtual machine by clicking through the Azure portal. This repository does the same from code: every change to `main` goes through a pipeline that waits for approval, builds the VM with Terraform, configures it with Ansible and checks that the page is online.

**Start here: [lab sheet (lab/LAB.md)](lab/LAB.md).** Fork this repository and follow it; it takes about an hour and works from any browser.

## How it works

```
Developer ──git push──► GitHub ──► GitHub Actions ──login (OIDC, no password)──► Azure
                                     │
                                     ├─ Terraform: network, firewall, public IP, Linux VM
                                     ├─ Ansible:   nginx + web page on the VM (over SSH)
                                     └─ Smoke test: the page shows the new version
```

| Workflow | When it runs | What it does |
|---|---|---|
| [CI](.github/workflows/ci.yml) | Every pull request to `main` | Format check, validation, Ansible syntax check, Terraform plan. Creates nothing |
| [CD](.github/workflows/cd.yml) | Every push to `main`, or manually | Plan, then **waits for approval** (environment `production`), then apply, Ansible and smoke test |
| [Destroy](.github/workflows/destroy.yml) | Manually only | After approval, deletes everything Terraform created |

## Repository layout

| Path | Content |
|---|---|
| `infra/` | Terraform: provider and remote state (`providers.tf`), inputs (`variables.tf`), the resources (`main.tf`), outputs including the Ansible inventory (`outputs.tf`) |
| `ansible/` | Playbook (wait for the VM, install nginx, deploy the page) and `ansible.cfg` |
| `app/index.html` | The web page; the smoke test checks the text in `<p id="version">` |
| `.github/workflows/` | The three pipelines above |
| `lab/` | The lab sheet and its screenshots |

## What gets created on Azure

One resource group `icn-devops-rg` (region Austria East) with a virtual network and subnet, a network security group allowing only SSH (22) and HTTP (80), a static public IP, a network interface and an Ubuntu 24.04 VM of size Standard_B2ats_v2 (2 vCPU, 1 GiB). Cost while it exists: about USD 0.02 per hour. Run **Destroy** when you finish.

The Terraform state is kept in your own Azure Storage account (container `tfstate`, file `demo.tfstate`), set up once in the lab.
