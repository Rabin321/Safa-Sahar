from fastapi import FastAPI, HTTPException
from passlib.hash import bcrypt
from pydantic import BaseModel
from sqlalchemy import create_engine, Column, String, Integer
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# MySQL database configurations
DATABASE_URL = "mysql+mysqlconnector://root:@localhost:3306/fyp"
engine = create_engine(DATABASE_URL)
Base = declarative_base()

class User(Base):
    __tablename__ = "user"
    id = Column(Integer, primary_key=True, index=True)
    full_name = Column(String(length=100))
    location = Column(String(length=255))
    email = Column(String(length=255), unique=True, index=True)
    hashed_password = Column(String(length=255))

Base.metadata.create_all(bind=engine)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

app = FastAPI()

class SignUpData(BaseModel):
    full_name: str
    location: str
    email: str
    password: str

@app.post("/signup")
async def signup(user_data: SignUpData):
    db = SessionLocal()
    db_user = db.query(User).filter(User.email == user_data.email).first()
    
    if db_user:
        raise HTTPException(status_code=400, detail="Email already registered")

    hashed_password = bcrypt.hash(user_data.password)
    db_user = User(full_name=user_data.full_name, location=user_data.location, email=user_data.email, hashed_password=hashed_password)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)

    return {"message": "User registered successfully"}



@app.get("/")
def read_root():
    try:
        # Your code here
        raise ValueError("Some error occurred")
    except ValueError as e:
        raise HTTPException(status_code=500, detail=str(e))
    
@app.post("/login")
def login(user_data: SignUpData):
    db = SessionLocal()
    
    # Check if the email is registered
    db_user = db.query(User).filter(User.email == user_data.email).first()

    if db_user and bcrypt.verify(user_data.password, db_user.hashed_password):
        # User is registered and password is correct
        db.close()
        return {"message": "Login successful"}
    else:
        # Either user not registered or password is incorrect
        db.close()
        raise HTTPException(status_code=401, detail="Invalid credentials")


class CheckLoginData(BaseModel):
    email: str
    password: str

@app.post("/check-login")
async def check_login(data: CheckLoginData):
    db = SessionLocal()
    db_user = db.query(User).filter(User.email == data.email).first()

    if db_user and bcrypt.verify(data.password, db_user.hashed_password):
        # User is registered, and login is successful
        db.close()
        return {"message": "Login successful"}
    else:
        # Either user not registered or password is incorrect
        db.close()
        raise HTTPException(status_code=401, detail="Invalid credentials")
