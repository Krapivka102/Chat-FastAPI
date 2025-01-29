from fastapi import APIRouter, Depends, HTTPException, FastAPI


def create_app() -> FastAPI:
    return FastAPI(
        title='FastAPI Chat',
        docs_url='/api/docs',
        description='DDD application'
    )