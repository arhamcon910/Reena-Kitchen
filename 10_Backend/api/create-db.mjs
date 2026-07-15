import { DatabaseSync } from "node:sqlite";
import { resolve } from "path";
const absPath = resolve("./reena.db");
console.log("Creating at:", absPath);
const db = new DatabaseSync(absPath);
db.exec(`CREATE TABLE users (
  id TEXT PRIMARY KEY NOT NULL,
  email TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  name TEXT,
  created_at DATETIME,
  updated_at DATETIME
)`);
console.log("Table created");
db.close();
