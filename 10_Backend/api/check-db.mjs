import { DatabaseSync } from "node:sqlite";
import { resolve } from "path";
const absPath = resolve("./reena.db");
console.log("DB path:", absPath);
const db = new DatabaseSync(absPath);
const tables = db.prepare("SELECT name FROM sqlite_master WHERE type='table'").all();
console.log("Tables:", JSON.stringify(tables));
db.close();
