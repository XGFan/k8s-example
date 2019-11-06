#!/bin/bash
helm dep update coin
helm install coin --namespace prod
