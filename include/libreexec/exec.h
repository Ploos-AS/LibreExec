#ifndef LIBREEXEC_EXEC_H
#define LIBREEXEC_EXEC_H

#include "libreexec/base.h"

typedef struct le_node {
    struct le_node *succ;
    struct le_node *pred;
    const char *name;
    le_s8 pri;
    le_u8 type;
} le_node;

typedef struct le_list {
    le_node *head;
    le_node *tail;
} le_list;

typedef enum le_task_state {
    LE_TASK_INVALID = 0,
    LE_TASK_READY,
    LE_TASK_RUNNING,
    LE_TASK_WAITING,
    LE_TASK_REMOVED
} le_task_state;

typedef struct le_task {
    le_node node;
    le_task_state state;
    le_u32 sig_alloc;
    le_u32 sig_wait;
    le_u32 sig_recvd;
} le_task;

typedef struct le_message {
    le_node node;
    le_u16 length;
    le_u16 flags;
} le_message;

typedef struct le_msgport {
    le_list messages;
    le_task *signal_task;
    le_u8 signal_bit;
} le_msgport;

void le_list_init(le_list *list);
int le_list_is_empty(const le_list *list);
void le_list_add_head(le_list *list, le_node *node);
void le_list_add_tail(le_list *list, le_node *node);
le_node *le_list_remove_head(le_list *list);
void le_list_remove(le_list *list, le_node *node);

void le_task_init(le_task *task, const char *name, le_s8 priority);
int le_task_set_state(le_task *task, le_task_state state);
int le_task_alloc_signal(le_task *task, le_u8 bit);
int le_task_free_signal(le_task *task, le_u8 bit);
void le_task_signal(le_task *task, le_u32 mask);
le_u32 le_task_take_signals(le_task *task, le_u32 mask);

void le_msgport_init(le_msgport *port, le_task *signal_task, le_u8 signal_bit);
int le_msgport_put(le_msgport *port, le_message *message);
le_message *le_msgport_get(le_msgport *port);

#endif
