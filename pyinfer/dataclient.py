# database/client.py
import psycopg
from dataclasses import dataclass
from typing import Optional

@dataclass
class DBConfig:
    host: str
    port: int
    user: str
    password: str
    database: str

class PGClient:
    def __init__(self, config: DBConfig):
        self.conn = psycopg.connect(
            host=config.host,
            port=config.port,
            user=config.user,
            password=config.password,
            dbname=config.database
        )
    
    def execute(self, query: str, params: Optional[tuple] = None):
        with self.conn.cursor() as cur:
            cur.execute(query, params)
            self.conn.commit()
            return cur

    def fetch(self, query: str, params: Optional[tuple] = None):
        with self.conn.cursor() as cur:
            cur.execute(query, params)
            return cur.fetchall()