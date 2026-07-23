from database import SessionLocal, Complaint
db = SessionLocal()
db.add(Complaint(description="Test Pothole", category="road", location="Main St"))
db.commit()
print("Complaints in DB:", len(db.query(Complaint).all()))
