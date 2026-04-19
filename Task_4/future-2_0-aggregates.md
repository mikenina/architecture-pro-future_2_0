# Ключевые агрегаты для междоменного взаимодействия

## FinTech Domain

### Aggregate: Payment
- **Корень:** payment_id (UUID)
- **Состав:** patient_id, appointment_id, amount, currency, status, created_at, updated_at
- **Инварианты:** amount > 0; статус не может измениться с COMPLETED обратно
- **Публикуемые события:** PaymentReceived, PaymentCompleted, PaymentFailed

### Aggregate: CustomerProfile
- **Корень:** customer_id (UUID)
- **Состав:** patient_id, credit_limit, debit_account_id, created_at
- **Инварианты:** credit_limit >= 0
- **Публикуемые события:** CustomerProfileCreated, CreditLimitUpdated

### Aggregate: CreditAgreement
- **Корень:** agreement_id (UUID)
- **Состав:** patient_id, amount, term_months, interest_rate, status
- **Инварианты:** amount <= credit_limit
- **Публикуемые события:** CreditAgreementSigned

---

## Clinic Domain

### Aggregate: Patient
- **Корень:** patient_id (UUID)
- **Состав:** full_name, dob, passport, snils, contact_phone
- **Инварианты:** Паспорт уникален
- **Публикуемые события:** PatientRegistered

### Aggregate: Appointment
- **Корень:** appointment_id (UUID)
- **Состав:** patient_id, doctor_id, time, status, holter_assigned_flag
- **Инварианты:** time не может быть в прошлом; статус CANCELLED нельзя изменить
- **Публикуемые события:** AppointmentCreated, HolterAssigned

### Aggregate: Visit
- **Корень:** visit_id (UUID)
- **Состав:** appointment_id, patient_id, doctor_id, start_time, end_time, payment_status
- **Инварианты:** payment_status не может быть PAID без завершённого платежа
- **Публикуемые события:** VisitCompleted

### Aggregate: InventoryItem
- **Корень:** (item_id, clinic_id) - композитный ключ
- **Состав:** item_name, quantity, reserved_quantity, threshold
- **Инварианты:** quantity >= 0; reserved_quantity <= quantity
- **Публикуемые события:** DeviceReserved, InventoryLow

---

## Streaming Domain

### Aggregate: TelemetrySession
- **Корень:** session_id (UUID)
- **Состав:** patient_id, device_id, start_time, end_time, status
- **Инварианты:** end_time >= start_time
- **Публикуемые события:** TelemetrySessionCreated

### Aggregate: TelemetryDataPoint
- **Корень:** (session_id, timestamp) - композитный ключ
- **Состав:** metric_type, value, unit
- **Инварианты:** timestamp не может быть в будущем

### Aggregate: Anomaly
- **Корень:** anomaly_id (UUID)
- **Состав:** session_id, patient_id, anomaly_type, severity, detected_at
- **Публикуемые события:** AnomalyDetected

---

## Medicine Domain

### Aggregate: MedicalRecord
- **Корень:** record_id (UUID)
- **Состав:** patient_id, diagnoses, prescriptions, payment_records, access_log
- **Инварианты:** Доступ только авторизованным врачам
- **Публикуемые события:** PaymentRecordAdded

### Aggregate: EmergencyAlert
- **Корень:** alert_id (UUID)
- **Состав:** patient_id, anomaly_type, severity, triggered_at, response_status
- **Публикуемые события:** EmergencyTriggered