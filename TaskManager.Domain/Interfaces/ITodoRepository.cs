using TaskManager.Domain.Entities;

namespace TaskManager.Application.Interfaces;

public interface ITodoRepository
{
    Task<List<TodoItem>> GetAllAsync();
    Task<TodoItem> AddAsync(TodoItem item);
}