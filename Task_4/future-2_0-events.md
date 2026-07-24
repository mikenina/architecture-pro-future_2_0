# Доменные события для междоменного взаимодействия

## События, передаваемые между доменами (через репликацию Kafka)

| Событие | Источник (домен) | Получатель (домен) | Семантика |
|:---|:---|:---|:---|
| `PatientRegistered` | Clinic Domain | FinTech Domain, Medicine Domain | Новый пациент зарегистрирован в системе |
| `HolterAssigned` | Clinic Domain | FinTech Domain, Streaming Domain, Medicine Domain | Пациенту назначен холтер-мониторинг |
| `PaymentCompleted` | FinTech Domain | Clinic Domain, Medicine Domain | Платёж успешно проведён |
| `AnomalyDetected` | Streaming Domain | Medicine Domain, Clinic Domain | Обнаружена аномалия в телеметрии |

## Внутренние события (публикуются внутри домена)

| Событие | Домен | Семантика |
|:---|:---|:---|
| `PaymentReceived` | FinTech Domain | Платёж поступил от внешнего шлюза |
| `PaymentConfirmed` | FinTech Domain | Платёж прошёл проверку |
| `CreditAgreementSigned` | FinTech Domain | Оформлен кредитный договор |
| `AppointmentCreated` | Clinic Domain | Создана запись к врачу |
| `VisitCompleted` | Clinic Domain | Визит завершён |
| `TelemetrySessionCreated` | Streaming Domain | Создана сессия сбора телеметрии |
| `TelemetryReceived` | Streaming Domain | Получена порция телеметрии |
| `PaymentRecordAdded` | Medicine Domain | Запись об оплате добавлена в медкарту |
| `EmergencyTriggered` | Medicine Domain | Инициирована экстренная реакция |

## Формат событий (минимальный контракт)

### PatientRegistered
```json
{
  "event_id": "uuid",
  "timestamp": "2024-01-15T10:30:00Z",
  "patient_id": "uuid",
  "full_name": "string",
  "dob": "YYYY-MM-DD",
  "passport": "string",
  "snils": "string"
}
```

### HolterAssigned
```json

{
  "event_id": "uuid",
  "timestamp": "2024-01-15T10:30:00Z",
  "appointment_id": "uuid",
  "patient_id": "uuid",
  "device_id": "uuid",
  "deposit_amount": "decimal"
}
```

### PaymentCompleted
```json

{
"event_id": "uuid",
"timestamp": "2024-01-15T10:30:00Z",
"payment_id": "uuid",
"appointment_id": "uuid",
"amount": "decimal",
"status": "COMPLETED"
}
```

### AnomalyDetected
```json
{
"event_id": "uuid",
"timestamp": "2024-01-15T10:30:00Z",
"session_id": "uuid",
"patient_id": "uuid",
"anomaly_type": "string",
"severity": "HIGH|MEDIUM|LOW",
"value": "decimal"
}
```