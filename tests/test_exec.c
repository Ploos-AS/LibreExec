#include <assert.h>
#include <stdio.h>

#include "libreexec/exec.h"

static void test_lists(void)
{
    le_list list;
    le_node a = {0};
    le_node b = {0};

    le_list_init(&list);
    assert(le_list_is_empty(&list));

    le_list_add_head(&list, &a);
    le_list_add_tail(&list, &b);
    assert(list.head == &a);
    assert(list.tail == &b);
    assert(a.succ == &b);
    assert(b.pred == &a);

    assert(le_list_remove_head(&list) == &a);
    assert(list.head == &b);
    le_list_remove(&list, &b);
    assert(le_list_is_empty(&list));
}

static void test_tasks_and_signals(void)
{
    le_task task;

    le_task_init(&task, "worker", 0);
    assert(task.state == LE_TASK_READY);
    assert(le_task_alloc_signal(&task, 5) == 0);
    assert(le_task_alloc_signal(&task, 5) == -1);

    le_task_signal(&task, (le_u32)1u << 5);
    assert(le_task_take_signals(&task, (le_u32)1u << 5) == ((le_u32)1u << 5));
    assert(le_task_take_signals(&task, (le_u32)1u << 5) == 0);
    assert(le_task_set_state(&task, LE_TASK_WAITING) == 0);
    assert(task.state == LE_TASK_WAITING);
    assert(le_task_free_signal(&task, 5) == 0);
}

static void test_message_port(void)
{
    le_task task;
    le_msgport port;
    le_message message = {0};
    le_u32 mask = (le_u32)1u << 3;

    le_task_init(&task, "receiver", 0);
    assert(le_task_alloc_signal(&task, 3) == 0);
    le_msgport_init(&port, &task, 3);

    message.length = 42;
    assert(le_msgport_put(&port, &message) == 0);
    assert((task.sig_recvd & mask) != 0);
    assert(le_msgport_get(&port) == &message);
    assert(le_msgport_get(&port) == NULL);
}

int main(void)
{
    test_lists();
    test_tasks_and_signals();
    test_message_port();
    puts("M1 Exec nucleus tests: PASS");
    return 0;
}
