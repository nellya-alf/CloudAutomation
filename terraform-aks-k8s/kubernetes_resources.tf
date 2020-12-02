# Creates Namespace for ingress
resource "kubernetes_namespace" "ingress_namespace" {
  metadata {
    name = "ingress"   
  }

  depends_on = [azurerm_kubernetes_cluster.kubernetes_cluster]
}

# Creates Namespace for web application
resource "kubernetes_namespace" "ratings_namespace" {
  metadata {
    name = "ratingsapp"   
  }
  
  depends_on = [azurerm_kubernetes_cluster.kubernetes_cluster]
}

# # Creates Namespace for Cert Manager
# resource "kubernetes_namespace" "certificate_namespace" {
#   metadata {
#     name = "cert-manager"   
#   }
# }

resource "helm_release" "ratings" {
  name       = "ratings"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "mongodb"
  namespace  = kubernetes_namespace.ratings_namespace.metadata[0].name

  set {
    name  = "auth.username"
    value = "testk8s"
  }

  set {
    name  = "auth.password"
    value = "1234"
  }

  set {
    name  = "auth.database"
    value = "ratingsdb"
  }
}

# resource "helm_release" "ngnix" {
#   name       = "ngnix"
#   repository = "https://kubernetes.github.io/ingress-nginx"
#   chart      = "ingress-nginx/ingress-nginx"
#   namespace  = kubernetes_namespace.ingress_namespace.name

#   set {
#     name  = ""
#     value = "testk8s"
#   }

#   set {
#     name  = "auth.password"
#     value = "1234"
#   }

#   set_string {
#     name  = "auth.database"
#     value = "ratingsdb"
#   }
# }