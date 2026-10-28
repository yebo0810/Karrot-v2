# Karrot-v2 — GAI3008 Mid-project

대학생을 위한 중고거래 UI 프로토타입입니다. 기존 당근(Karrot) 앱의 지역 기반 거래 경험을 참고하여 상품 상태를 쉽게 확인하고, 중고 상품·구해요·모의 경매 화면을 탐색할 수 있도록 구성했습니다.

> **프로젝트 범위:** 수업 과제용 UI 프로토타입입니다. 실제 거래, 게시글 저장, 실제 입찰, 로그인·결제, 실제 AI API는 구현하지 않았습니다.

## 1. 주요 기능

- **중고 상품 목록:** 상품 검색, 태그/카테고리 필터, 상품 카드 표시
- **상품 상세:** 상품 이미지, 제목, 가격, 위치, 설명 및 거래 상태 표시
- **구해요:** 구매 희망 게시글 작성 화면 예시 모달
- **모의 경매:** 사전 정의된 경매 상품과 시작 가격 표시
- **AI 상품 설명 제안:** 사전 정의된 제목·설명 예시를 보여 주는 UI
- **데이터 가져오기:** 로컬 `json-server`에서 HTTP GET으로 상품 데이터 가져오기
- **상태 화면:** 로딩, 오류, 빈 목록 상태 예시
- **반응형 레이아웃:** 화면 너비에 따라 목록/그리드 레이아웃 변경

## 2. 기술 스택

- Flutter / Dart
- `http` 패키지
- `json-server` 0.17.4
- JSON mock data (`mock_server/db.json`)

## 3. 프로젝트 구조

```text
Karrot-v2/
├── lib/
│   ├── main.dart
│   ├── api.dart
│   ├── models.dart
│   ├── widgets.dart
│   └── screens/
│       ├── a_list_screen.dart
│       ├── b_detail_screen.dart
│       └── c_result_sheet.dart
├── mock_server/
│   ├── db.json
│   └── package.json
├── docs/
│   ├── design-guide.md
│   ├── principle-card.md
│   ├── prompt-log.md
│   ├── self-argumentation.md
│   └── self-evaluation.md
├── pubspec.yaml
└── README.md
```

## 4. 실행 환경 준비

먼저 설치되어 있어야 합니다.

- Flutter SDK
- Dart (Flutter SDK에 포함)
- Node.js 및 npm
- VS Code (권장)

터미널에서 버전을 확인할 수 있습니다.

```bash
flutter --version
node --version
npm --version
```

## 5. 실행 방법

### 5.1. 데이터 서버 실행

프로젝트 루트에서 새 터미널을 열고 실행합니다.

```bash
cd mock_server
npm install
npm start
```

JSON Server는 기본적으로 `http://localhost:3000`에서 실행됩니다. 상품 목록 API는 다음 주소입니다.

```text
http://localhost:3000/items
```

Windows PowerShell에서 `npm.ps1` 실행 정책 오류가 발생하면 다음 명령을 사용합니다.

```powershell
npm.cmd install
npm.cmd start
```

서버 터미널은 실행 중인 상태로 유지합니다.

### 5.2. Flutter 웹 실행

프로젝트 루트에서 다른 터미널을 열고 실행합니다.

```bash
flutter pub get
flutter run -d edge
```

웹 플랫폼 설정이 없는 경우 프로젝트 루트에서 한 번 실행합니다.

```bash
flutter create --platforms=web .
```

그 후 다시 실행합니다.

```bash
flutter run -d edge
```

### 5.3. Windows / Android 실행 참고

- Android 에뮬레이터는 기본적으로 `http://10.0.2.2:3000`을 사용합니다.
- Edge/Chrome 웹 실행은 기본적으로 `http://localhost:3000`을 사용합니다.
- 실제 휴대폰에서 테스트하려면 휴대폰과 PC가 같은 Wi-Fi에 연결되어 있어야 하며, API 주소를 PC의 LAN IPv4 주소로 지정해야 합니다. 예시:

```bash
flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8080 --dart-define=API_BASE=http://192.168.0.10:3000
```

위의 `192.168.0.10`은 예시 주소입니다. `ipconfig`에서 PC의 실제 IPv4 주소를 확인해 바꾸세요. 방화벽에서 필요한 포트의 로컬 네트워크 연결을 허용해야 할 수도 있습니다.

## 6. 로딩 / 오류 / 빈 목록 상태 시연

프로젝트 루트에서 각각 실행합니다.

```bash
flutter run -d edge --dart-define=DEMO_STATE=loading
flutter run -d edge --dart-define=DEMO_STATE=error
flutter run -d edge --dart-define=DEMO_STATE=empty
```

- `loading`: 응답을 일부러 지연하여 로딩 UI를 확인합니다.
- `error`: 오류 UI를 확인합니다.
- `empty`: 빈 목록 UI를 확인합니다.

일반 실행으로 돌아가려면 `DEMO_STATE` 옵션 없이 다시 실행합니다.

## 7. 주요 파일 설명

- `lib/main.dart`: 앱 진입점과 테마
- `lib/screens/a_list_screen.dart`: 상품 목록, 검색, 필터 및 탭 UI
- `lib/screens/b_detail_screen.dart`: 상품 상세 화면
- `lib/screens/c_result_sheet.dart`: AI 설명·구해요·경매 관련 예시 모달
- `lib/api.dart`: GET 요청과 로딩/오류/빈 상태 시연 옵션
- `lib/models.dart`: JSON 데이터 모델
- `mock_server/db.json`: 데모용 상품 데이터
- `docs/`: 디자인 가이드, 원칙 카드, AI 프롬프트 로그, 셀프 논증 및 자가평가 기록

## 8. 과제 범위 및 제한

- 데이터 조회는 `GET` 요청만 사용합니다.
- `POST`, `PUT`, `DELETE`를 통한 데이터 변경은 구현하지 않았습니다.
- 로그인, 결제, 실제 채팅, 실제 거래, 실제 입찰 및 영구 저장은 제공하지 않습니다.
- AI 설명은 미리 준비된 예시 UI이며 실제 AI API를 호출하지 않습니다.
- 게시글/경매 등록 버튼은 안내용 UI만 표시하며 데이터를 저장하지 않습니다.
- 상품 이미지는 데모용 외부 이미지 URL을 사용하므로 네트워크 연결이 필요할 수 있습니다.