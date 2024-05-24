[
  {
    "name": "django-ecommerce-store",
    "image": "ecr_repo_uri",
    "cpu": 256,
    "memory": 512,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ],
    "environment": [
      {
        "name": "POSTGRES_HOST",
        "value": "${postgres_host}"
      },
      {
        "name": "POSTGRES_USER",
        "value": "${postgres_user}"
      },
      {
        "name": "POSTGRES_PASSWORD",
        "value": "${postgres_password}"
      },
      {
        "name": "POSTGRES_DB",
        "value": "${postgres_db}"
      },
      {
        "name": "POSTGRES_PORT",
        "value": "${postgres_port}"
      }
    ]
  }
]
