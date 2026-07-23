import os
from datetime import datetime
from sqlalchemy import create_engine, Column, Integer, String, Text, DateTime, ForeignKey
from sqlalchemy.orm import declarative_base, sessionmaker

DATABASE_URL = "sqlite:///./civicpulse.db"

engine = create_engine(DATABASE_URL, connect_args={"check_same_thread": False})
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()

class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True, index=True)
    username = Column(String, unique=True, index=True)
    role = Column(String, default="citizen") # "citizen" or "admin"
    created_at = Column(DateTime, default=datetime.utcnow)

class Complaint(Base):
    __tablename__ = "complaints"
    id = Column(Integer, primary_key=True, index=True)
    description = Column(Text, nullable=False)
    category = Column(String, nullable=False) # e.g. "pothole", "streetlight"
    location = Column(String, nullable=False)
    date = Column(String, nullable=True)
    status = Column(String, default="pending") # pending, reviewed, resolved, rejected
    reporter_contact = Column(String, nullable=True)
    image_url = Column(String, nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow)

class LostItem(Base):
    __tablename__ = "lost_items"
    id = Column(Integer, primary_key=True, index=True)
    description = Column(Text, nullable=False)
    category = Column(String, nullable=False) # e.g. "passport", "wallet"
    location = Column(String, nullable=False)
    date = Column(String, nullable=False)
    status = Column(String, default="pending") # pending, reviewed, resolved, rejected
    reporter_contact = Column(String, nullable=True)
    image_url = Column(String, nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow)

class FoundItem(Base):
    __tablename__ = "found_items"
    id = Column(Integer, primary_key=True, index=True)
    description = Column(Text, nullable=False)
    category = Column(String, nullable=False)
    location = Column(String, nullable=False)
    date = Column(String, nullable=False)
    status = Column(String, default="pending") # pending, claimed
    reporter_contact = Column(String, nullable=True)
    image_url = Column(String, nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow)

class AdminReview(Base):
    __tablename__ = "admin_reviews"
    id = Column(Integer, primary_key=True, index=True)
    item_type = Column(String, nullable=False) # "complaint", "lost_item", "found_item"
    item_id = Column(Integer, nullable=False)
    admin_id = Column(Integer, ForeignKey("users.id"))
    action = Column(String, nullable=False) # "approved", "rejected", "resolved"
    created_at = Column(DateTime, default=datetime.utcnow)

# Dependency for FastAPI
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# Create tables if they don't exist
Base.metadata.create_all(bind=engine)
