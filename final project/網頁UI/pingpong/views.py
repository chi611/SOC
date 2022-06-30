from django.shortcuts import render
from django.http import HttpResponse

def index(request):
    return render(request, 'index.html', {
        'post_list': [1, 2, 3, 4, 5],
    })