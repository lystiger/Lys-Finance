# ROLE

You are now acting as the **Chief Software Architect**, **Principal Flutter Engineer**, **Senior Mobile Tech Lead**, **DevOps Lead**, and **Code Quality Lead**.

You have already completed the Product Design Document and Software Requirements Specification.

This task is NOT to rewrite that document.

Instead, create a SECOND document that complements it.

This document should become the engineering handbook that every developer follows before writing code.

Think of this as the Technical Design Document (TDD) and Engineering Standards.

The Product Design Document already defines WHAT to build.

Your job is to define HOW it should be built.

Assume the implementation engineer (Codex) is extremely capable but should make as few architectural decisions as possible.

Every important engineering decision should already be made.

---

# DOCUMENT TITLE

Lys Finance

Engineering Architecture & Technical Design Document

Version 1.0

---

# OBJECTIVES

This document should:

* eliminate implementation ambiguity
* define engineering standards
* define architecture
* define coding style
* define package structure
* define dependency rules
* define state management rules
* define testing strategy
* define CI/CD
* define release workflow
* maximize maintainability
* maximize scalability

Do NOT write Flutter code.

Only write technical documentation.

---

# REQUIRED SECTIONS

---

# 1 Engineering Principles

Examples

Single Source of Truth

Offline First

Repository Pattern

Clean Architecture

Feature First

Composition over inheritance

SOLID

DRY

KISS

YAGNI

Explain WHY each principle is used.

---

# 2 Technology Stack

Specify exact versions whenever possible.

Flutter

Dart

Riverpod

Drift

SQLite

Go Router

Freezed

Json Serializable

Flutter Local Notifications

Flutter Secure Storage

Shared Preferences

Intl

Logger

UUID

fl_chart

Build Runner

Any additional recommended packages.

Explain why each package is chosen.

Also list packages intentionally NOT used and why.

---

# 3 Project Folder Structure

Design a production-ready folder hierarchy.

Explain every folder.

Example

lib/

app/

core/

config/

theme/

database/

services/

repositories/

features/

dashboard/

transactions/

vault/

budget/

subscription/

analytics/

assistant/

settings/

shared/

widgets/

extensions/

utils/

assets/

fonts/

animations/

tests/

etc.

---

# 4 Feature Module Standard

Every feature must follow one architecture.

Example

Presentation

Application

Domain

Data

Infrastructure

Widgets

Explain responsibilities.

---

# 5 State Management Rules

Explain exactly when to use

Provider

Notifier

AsyncNotifier

FutureProvider

StreamProvider

AutoDispose

Family Providers

Dependency Injection

Caching

State restoration

Rules for derived state

Rules for immutable state

---

# 6 Database Design Rules

How Drift should be organized.

DAO naming.

Migration policy.

Indexes.

Transactions.

Versioning.

Soft delete.

Currency precision.

Backup strategy.

Database testing.

---

# 7 Repository Layer

Design repository interfaces.

TransactionRepository

BudgetRepository

VaultRepository

SettingsRepository

AnalyticsRepository

NotificationRepository

SubscriptionRepository

AIRepository

Describe responsibilities.

---

# 8 Service Layer

Design all services.

BudgetService

VaultService

HealthScoreService

AnalyticsService

NotificationService

CurrencyService

BackupService

ExportService

ImportService

AIService

Explain responsibilities.

---

# 9 Dependency Graph

Explain allowed dependencies.

Presentation

↓

Application

↓

Domain

↓

Data

↓

SQLite

No circular dependencies.

Include dependency diagrams using Mermaid.

---

# 10 Error Handling

Global error handling.

Repository errors.

Database errors.

Validation errors.

Unexpected errors.

Logging strategy.

Retry strategy.

User-friendly messages.

Crash recovery.

---

# 11 Logging Strategy

Logging levels.

Debug

Info

Warning

Error

Critical

When to log.

What NEVER to log.

PII handling.

Financial information masking.

---

# 12 Security

Local database security.

Secure storage.

Encryption.

Biometric authentication.

PIN lock.

Export encryption.

Sensitive data handling.

Clipboard policy.

Screenshot policy.

Root detection (future).

---

# 13 Theme Architecture

Material 3 customization.

Theme Extensions.

Typography system.

Color tokens.

Spacing tokens.

Elevation tokens.

Animation tokens.

Dark mode strategy.

---

# 14 Navigation Architecture

Go Router structure.

Nested navigation.

Deep linking.

Modal routes.

Bottom navigation.

Future web compatibility.

---

# 15 Notification Architecture

Scheduling.

Notification channels.

Reminder engine.

Background execution.

Future push notification support.

---

# 16 AI Architecture

Design a provider-independent AI layer.

Context Builder

Prompt Builder

Tool Layer

Parser

Conversation History

Future Local LLM

Future Elysia Integration

Future MCP Integration

Explain every layer.

---

# 17 Configuration Management

Environment variables.

Development.

Staging.

Production.

Secrets management.

API Keys.

Feature flags.

Build flavors.

---

# 18 Testing Strategy

Unit tests.

Widget tests.

Golden tests.

Integration tests.

Repository tests.

Database tests.

Coverage goals.

Mocking strategy.

Testing folder structure.

---

# 19 CI/CD

GitHub Actions workflow.

Flutter Analyze.

Flutter Test.

Formatting.

Build Runner verification.

APK generation.

Release pipeline.

Future Play Store deployment.

---

# 20 Performance Targets

Cold startup

Warm startup

Frame rate

Database query time

Notification latency

Search latency

Memory usage

Battery usage

APK size

Offline availability

Maximum supported transaction count

Performance budgets.

---

# 21 Code Style Guide

Naming conventions.

File naming.

Folder naming.

Widget naming.

Riverpod naming.

Repository naming.

Database naming.

Constants.

Enums.

Extensions.

Comments.

Documentation.

DartDoc standards.

---

# 22 Git Workflow

Git Flow.

Branch naming.

Commit message conventions.

Pull request template.

Review checklist.

Release tags.

Versioning strategy.

Semantic Versioning.

---

# 23 Future Scalability

Cloud Sync.

Supabase.

FastAPI backend.

Desktop.

Web.

WearOS.

Apple Watch.

Family accounts.

Investment tracking.

OCR.

Receipt scanning.

AI Financial Coach.

Elysia Integration.

---

# 24 Risk Assessment

Identify every possible technical risk.

Architecture risks.

Database risks.

Performance risks.

Security risks.

Maintainability risks.

Dependency risks.

Mitigation strategy.

---

# 25 Engineering Checklist

Create a final checklist.

Every module.

Every architecture rule.

Every coding standard.

Every dependency rule.

Every testing requirement.

Every performance target.

This checklist will be used during every code review.

---

# OUTPUT REQUIREMENTS

The document should resemble an internal engineering handbook used by companies like Google, Stripe, Linear, Notion, or Shopify.

Every recommendation should include a rationale.

Include Mermaid diagrams wherever appropriate.

Do NOT generate Flutter code.

Do NOT generate Dart code.

Do NOT generate SQL.

Produce only engineering documentation.

The final output should remove nearly all architectural decisions from the implementation phase so that Codex can focus exclusively on writing clean, production-quality code.
