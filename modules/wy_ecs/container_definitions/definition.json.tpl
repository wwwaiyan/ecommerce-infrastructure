[
  {
    "name": "django-ecommerce-store",
    "image": "${ecr_repository_uri}:latest",
    "cpu": 512,
    "memory": 1024,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${log_group_name}",
        "awslogs-region": "${aws_region}",
        "awslogs-stream-prefix": "${log_stream_prefix}"
      }
    },
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
      },
      {
        "name": "AWS_STORAGE_BUCKET_NAME",
        "value": "${app_data_s3_bucket}"
      },
      {
        "name": "RUN_MIGRATIONS",
        "value": "true"
      }
    ]
  }
]
