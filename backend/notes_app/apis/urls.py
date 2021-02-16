from django.urls import path
from .views import listTodo, DetailTodo

urlpatterns = [
    path('', listTodo.as_view()),
    path('<int:pk>/', DetailTodo.as_view())
]