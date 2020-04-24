# Somul Infrastructure

> 본 Repository에는 Terraform을 이용한 IaaC(Infrastructure as a Code)가 적용되어있습니다. [Terraform](https://www.terraform.io/)은 HCL이라는 간단한 언어를 통해서 전체 Infrastructure를 정의하고 배포할 수 있습니다. 

## How to: Infrastructure Deployment

> 본 가이드에서는 사용자가 AWS 상의 환경에 서버 클러스터를 배포한다고 가정합니다. `/terraform` 안의 배포 스크립트 또한 AWS 기준으로 짜여져 있습니다.

### 0. Prerequisites
1. ec2 key pair 생성
2. AWS 인증서 발급
  - Domain 생성
  - 인증서관련 도메인 인증
3. AWS SES 셋업
  - AWS SES 샌드박스 모드 취소하기
  - master email 등록하기

### 1. Terraform 설정

[Downloads](https://www.terraform.io/downloads.html) 페이지를 참조하여 Terrraform을 설치해주십시오. 형태는 Binary 파일이며, 직접 적절한 곳에 배치하시고 각 OS의 `PATH`를 업데이트해주셔야 합니다.

정상적으로 설치된 경우 다음과 같이 실행되어야 합니다.

```bash
$ terraform --version

Terraform v0.12.3 # 최소 버전입니다. 출력 버전은 다를 수 있습니다.

$ terraform init # 테라폼 설치 후에 다음과 같은 명령을 입렵한다.
```
variables.tf 에서 ec2 key pair 이름을 "<<key-pair-name>>"에 삽입하고, AWS 인증서 acm은 "<<certificate acm>>"에 삽입한다.


### 2. Terraform 실행

`/terraform` 경로에서 다음을 실행합니다.

```bash
# prod 인경우
$ terraform workspace prod

# staging 인경우
$ terraform workspace staging
```

```bash
$ terraform plan
```

해당 Terraform 정의가 적용될 경우 어떤 변화가 일어날 것인지를 모니터링할 수 있습니다. 해당 정의가 적절하다고 생각될 경우 다음을 통해 실제 Provisioning을 실행합니다.

```bash
$ terraform apply
```

#### Outputs

수 분 후에 실행이 종료되면, 다음 명령어를 실행하십시오.

```bash
$ terraform outputs

server_public_ip = 52.79.226.211
```

## How to deploy Server
```
// somul-system-backend repo에서 .env.sample 파일 참고해서 env_path에 .env파일 생성하기
sudo docker run --name=somul -d -v {env_path}:/somul-server/.env somul/backend:{tag}
```
- ubuntu 18.04 환경에서 배포를 권장.
- 도커 설치는 다음 url 참고 (https://blog.cosmosfarm.com/archives/248/%EC%9A%B0%EB%B6%84%ED%88%AC-18-04-%EB%8F%84%EC%BB%A4-docker-%EC%84%A4%EC%B9%98-%EB%B0%A9%EB%B2%95/)
- staging 인 경우 tag를 staging으로 명시
- 로그는 다음 명령어로 확인 가능 sudo docker logs -f somul