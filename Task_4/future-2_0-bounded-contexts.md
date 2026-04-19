# Bounded Contexts «Будущее 2.0»

## FinTech Domain

### Payment Gateway Context
- **Ответственность:** Приём платежей от внешних систем (банки, платёжные шлюзы)
- **Ключевые понятия:** Transaction, PaymentRequest, GatewayResponse
- **Публикуемые события:** PaymentReceived

### Payment Processing Context
- **Ответственность:** Обработка транзакций, управление статусами платежей
- **Ключевые понятия:** Payment, PaymentStatus, Refund
- **Инварианты:** Сумма платежа не может быть отрицательной; статус COMPLETED нельзя изменить
- **Публикуемые события:** PaymentCompleted, PaymentFailed, PaymentRefunded

### Payment Verification Context
- **Ответственность:** Проверка платежей на мошенничество, лимиты, кредитную историю
- **Ключевые понятия:** VerificationResult, FraudCheck, LimitCheck
- **Публикуемые события:** PaymentConfirmed, PaymentRejected

### Customer Profile Context
- **Ответственность:** Управление финансовыми профилями пациентов
- **Ключевые понятия:** CustomerProfile, CreditLimit, DebitAccount
- **Публикуемые события:** CustomerProfileCreated, CreditLimitUpdated

### Credit Agreement Context
- **Ответственность:** Оформление кредитных договоров на лечение
- **Ключевые понятия:** CreditAgreement, CreditTerms, RepaymentSchedule
- **Инварианты:** Сумма кредита не превышает кредитный лимит пациента
- **Публикуемые события:** CreditAgreementSigned, CreditAgreementClosed

---

## Clinic Domain

### Patient Registration Context
- **Ответственность:** Регистрация новых пациентов в системе клиники
- **Ключевые понятия:** Patient, PatientDemographics, ContactInfo
- **Инварианты:** Паспортные данные уникальны
- **Публикуемые события:** PatientRegistered

### Appointment Context
- **Ответственность:** Управление расписанием врачей и записью пациентов
- **Ключевые понятия:** Appointment, DoctorSchedule, TimeSlot
- **Инварианты:** У врача не может быть двух записей в одно время
- **Публикуемые события:** AppointmentCreated, AppointmentCancelled, AppointmentRescheduled, HolterAssigned

### Patient Visit Context
- **Ответственность:** Обслуживание пациента от входа до выхода
- **Ключевые понятия:** Visit, VisitStatus, ServicePerformed
- **Инварианты:** Визит не может быть завершён без закрытия всех назначений
- **Публикуемые события:** VisitStarted, VisitCompleted

### Inventory Context
- **Ответственность:** Учёт медицинского оборудования и расходников
- **Ключевые понятия:** InventoryItem, StockLevel, Reservation
- **Инварианты:** Количество не может быть отрицательным
- **Публикуемые события:** InventoryLow, DeviceReserved

### Notification Context
- **Ответственность:** Отправка уведомлений пациентам и врачам
- **Ключевые понятия:** Notification, NotificationChannel (SMS, Email, Push)
- **Публикуемые события:** NotificationSent

---

## Streaming Domain

### Telemetry Preparation Context
- **Ответственность:** Подготовка сессии сбора данных с носимых устройств и оборудования
- **Ключевые понятия:** TelemetrySession, DeviceConfig, SessionStatus
- **Публикуемые события:** TelemetrySessionCreated

### Telemetry Processing Context
- **Ответственность:** Приём, валидация и предобработка потока телеметрии
- **Ключевые понятия:** TelemetryData, DataPoint, Timestamp
- **Инварианты:** Каждое измерение содержит timestamp
- **Публикуемые события:** TelemetryReceived

### Anomaly Detection Context
- **Ответственность:** Обнаружение аномалий в потоке телеметрии
- **Ключевые понятия:** Anomaly, AnomalyType, Severity, Threshold
- **Публикуемые события:** AnomalyDetected

---

## Medicine Domain

### Medical Records Context
- **Ответственность:** Ведение медицинской карты, диагнозов, назначений
- **Ключевые понятия:** MedicalRecord, Diagnosis, Prescription, MedicalHistory
- **Инварианты:** Доступ только авторизованным врачам; аудит всех изменений
- **Публикуемые события:** MedicalRecordUpdated, PaymentRecordAdded

### Emergency Context
- **Ответственность:** Обработка экстренных ситуаций (вызов скорой, срочный приём)
- **Ключевые понятия:** EmergencyAlert, EscalationLevel, ResponseStatus
- **Публикуемые события:** EmergencyTriggered

### Billing Context
- **Ответственность:** Учёт финансовых операций в медицинской карте
- **Ключевые понятия:** PaymentRecord, Invoice, PaymentStatus
- **Публикуемые события:** BillingStatusUpdated