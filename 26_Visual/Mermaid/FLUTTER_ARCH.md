# Flutter Architecture

```mermaid
graph TD
    subgraph Features
        HS[Home] PA[Pantry] CJ[Journey]
        TR[Talk] PL[Planner] DI[Discover] BO[BetaOps]
    end
    subgraph Core
        BRAIN[ReenaBrain] LEARN[LearningProfile]
        ANA[Analytics] ERR[CrashReporter]
        MIG[SpMigration] UDS[UserDataService]
    end
    subgraph Packages
        DE[decision_engine] AI[ai_sdk] KV[knowledge_vault]
    end
    subgraph Persistence
        SP[(SharedPreferences reena.*.v1)]
    end
    Features --> Core
    Core --> Packages
    Core --> SP
    MIG --> SP
    LEARN --> SP
```
