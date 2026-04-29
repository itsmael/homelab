resource "kubernetes_namespace_v1" "wikijs" { # <--- O nome aqui deve ser "wikijs"
  metadata {
    name = var.namespace
  }
}
resource "helm_release" "wikijs" {
  name       = "wikijs"
  repository = "https://charts.js.wiki"
  chart      = "wiki"
  namespace  = kubernetes_namespace_v1.wikijs.metadata[0].name
  
  # Remova a versão para garantir o latest, como combinado
  
  set {
    name  = "postgresql.enabled"
    value = "true"
  }

  set {
    name  = "postgresql.persistence.size"
    value = var.db_size
  }

  set {
    name  = "ingress.enabled"
    value = "true"
  }

  set {
    name  = "ingress.hosts[0].host"
    value = var.domain
  }

  # ADICIONE ESTAS DUAS LINHAS PARA CORRIGIR O ERRO:
  set {
    name  = "ingress.hosts[0].paths[0].path"
    value = "/"
  }
  set {
    name  = "ingress.hosts[0].paths[0].pathType"
    value = "ImplementationSpecific"
  }
  
  set {
    name  = "persistence.enabled"
    value = "true"
  }
}
