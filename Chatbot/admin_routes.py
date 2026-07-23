from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from pydantic import BaseModel
from typing import List, Optional

from database import get_db, Complaint, LostItem, FoundItem, AdminReview

router = APIRouter(prefix="/admin", tags=["admin"])

class ReviewUpdate(BaseModel):
    status: str # "approved", "rejected", "resolved"
    admin_id: Optional[int] = 1 # hardcoded admin ID for simplicity

@router.get("/complaints")
def get_complaints(db: Session = Depends(get_db)):
    return db.query(Complaint).all()

@router.get("/lost-items")
def get_lost_items(db: Session = Depends(get_db)):
    return db.query(LostItem).all()

@router.get("/found-items")
def get_found_items(db: Session = Depends(get_db)):
    return db.query(FoundItem).all()

@router.patch("/review/{item_type}/{item_id}")
def update_status(item_type: str, item_id: int, review: ReviewUpdate, db: Session = Depends(get_db)):
    """
    item_type should be 'complaint', 'lost_item', or 'found_item'
    """
    valid_statuses = ["approved", "rejected", "resolved", "pending"]
    if review.status not in valid_statuses:
        raise HTTPException(status_code=400, detail="Invalid status")

    item = None
    if item_type == "complaint":
        item = db.query(Complaint).filter(Complaint.id == item_id).first()
    elif item_type == "lost_item":
        item = db.query(LostItem).filter(LostItem.id == item_id).first()
    elif item_type == "found_item":
        item = db.query(FoundItem).filter(FoundItem.id == item_id).first()
    else:
        raise HTTPException(status_code=400, detail="Invalid item_type")

    if not item:
        raise HTTPException(status_code=404, detail="Item not found")

    item.status = review.status
    
    # Log the review action
    admin_review = AdminReview(
        item_type=item_type,
        item_id=item_id,
        admin_id=review.admin_id,
        action=review.status
    )
    db.add(admin_review)
    db.commit()
    db.refresh(item)
    return {"message": "Status updated successfully", "item": item}
