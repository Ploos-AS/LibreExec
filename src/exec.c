#include <stddef.h>

#include "libreexec/exec.h"

void le_list_init(le_list *list)
{
    list->head = NULL;
    list->tail = NULL;
}

int le_list_is_empty(const le_list *list)
{
    return list->head == NULL;
}

void le_list_add_head(le_list *list, le_node *node)
{
    node->pred = NULL;
    node->succ = list->head;
    if (list->head != NULL)
        list->head->pred = node;
    else
        list->tail = node;
    list->head = node;
}

void le_list_add_tail(le_list *list, le_node *node)
{
    node->succ = NULL;
    node->pred = list->tail;
    if (list->tail != NULL)
        list->tail->succ = node;
    else
        list->head = node;
    list->tail = node;
}

le_node *le_list_remove_head(le_list *list)
{
    le_node *node = list->head;
    if (node == NULL)
        return NULL;

    list->head = node->succ;
    if (list->head != NULL)
        list->head->pred = NULL;
    else
        list->tail = NULL;

    node->succ = NULL;
    node->pred = NULL;
    return node;
}

void le_list_remove(le_list *list, le_node *node)
{
    if (node->pred != NULL)
        node->pred->succ = node->succ;
    else if (list->head == node)
        list->head = node->succ;

    if (node->succ != NULL)
        node->succ->pred = node->pred;
    else if (list->tail == node)
        list->tail = node->pred;

    node->succ = NULL;
    node->pred = NULL;
}

void le_task_init(le_task *task, const char *name, le_s8 priority)
{
    task->node.succ = NULL;
    task->node.pred = NULL;
    task->node.name = name;
    task->node.pri = priority;
    task->node.type = 0;
    task->state = LE_TASK_READY;
    task->sig_alloc = 0;
    task->sig_wait = 0;
    task->sig_recvd = 0;
}

int le_task_set_state(le_task *task, le_task_state state)
{
    if (state <= LE_TASK_INVALID || state > LE_TASK_REMOVED)
        return -1;
    task->state = state;
    return 0;
}

int le_task_alloc_signal(le_task *task, le_u8 bit)
{
    le_u32 mask;
    if (bit >= 32)
        return -1;
    mask = (le_u32)1u << bit;
    if ((task->sig_alloc & mask) != 0)
        return -1;
    task->sig_alloc |= mask;
    return 0;
}

int le_task_free_signal(le_task *task, le_u8 bit)
{
    le_u32 mask;
    if (bit >= 32)
        return -1;
    mask = (le_u32)1u << bit;
    if ((task->sig_alloc & mask) == 0)
        return -1;
    task->sig_alloc &= ~mask;
    task->sig_wait &= ~mask;
    task->sig_recvd &= ~mask;
    return 0;
}

void le_task_signal(le_task *task, le_u32 mask)
{
    task->sig_recvd |= mask & task->sig_alloc;
}

le_u32 le_task_take_signals(le_task *task, le_u32 mask)
{
    le_u32 got = task->sig_recvd & mask;
    task->sig_recvd &= ~got;
    return got;
}

void le_msgport_init(le_msgport *port, le_task *signal_task, le_u8 signal_bit)
{
    le_list_init(&port->messages);
    port->signal_task = signal_task;
    port->signal_bit = signal_bit;
}

int le_msgport_put(le_msgport *port, le_message *message)
{
    if (port->signal_task == NULL || port->signal_bit >= 32)
        return -1;
    le_list_add_tail(&port->messages, &message->node);
    le_task_signal(port->signal_task, (le_u32)1u << port->signal_bit);
    return 0;
}

le_message *le_msgport_get(le_msgport *port)
{
    le_node *node = le_list_remove_head(&port->messages);
    if (node == NULL)
        return NULL;
    return (le_message *)node;
}
