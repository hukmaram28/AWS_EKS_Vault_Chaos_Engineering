provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
    # host                   = data.aws_eks_cluster.cluster.endpoint
    # cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    # token                  = data.aws_eks_cluster_auth.cluster.token
  }
}

resource "helm_release" "db" {
  name       = "db"
  chart      = "../../helm/db"
  namespace = var.namespace

  set {
    name  = "secret.db_username"
    value = var.db_username
  }
  set {
    name  = "secret.db_password"
    value = var.db_password
  }
  set {
    name  = "secret.db_root_password"
    value = var.db_root_password
  }
  # set {
  #   name  = "secret.db_username"
  #   value = data.vault_kv_secret_v2.crypteye.data["db_username"]
  # }
  # set {
  #   name  = "secret.db_password"
  #   value = data.vault_kv_secret_v2.crypteye.data["db_password"]
  # }
  # set {
  #   name  = "secret.db_root_password"
  #   value = data.vault_kv_secret_v2.crypteye.data["db_root_password"]
  # }
}
