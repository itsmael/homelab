terraform {
  required_version = ">= 1.8.0"

  # ESTE BLOCO É OBRIGATÓRIO PARA MATAR O ERRO
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.15.0" # Força a linha v2 que aceita o bloco kubernetes
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.31.0"
    }
  }

  backend "kubernetes" {
    secret_suffix = "wikijs-state"
    config_path   = "~/.kube/config"
    namespace     = "kube-system"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
