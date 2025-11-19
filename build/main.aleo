import workshop_ofac.aleo;
program pedrogattai_workshop_token.aleo;

record Token:
    owner as address.private;
    amount as u64.private;

mapping balances:
    key as address.public;
    value as u64.public;

function dummy:

function mint_public:
    input r0 as address.public;
    input r1 as u64.private;
    call workshop_ofac.aleo/address_check r0 into r2;
    async mint_public r0 r1 r2 into r3;
    output r3 as pedrogattai_workshop_token.aleo/mint_public.future;

finalize mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as workshop_ofac.aleo/address_check.future;
    await r2;
    get.or_use balances[r0] 0u64 into r3;
    add r3 r1 into r4;
    set r4 into balances[r0];

function mint_private:
    input r0 as address.private;
    input r1 as u64.private;
    cast r0 r1 into r2 as Token.record;
    call workshop_ofac.aleo/address_check r0 into r3;
    async mint_private r3 into r4;
    output r2 as Token.record;
    output r4 as pedrogattai_workshop_token.aleo/mint_private.future;

finalize mint_private:
    input r0 as workshop_ofac.aleo/address_check.future;
    await r0;

constructor:
    assert.eq edition 0u16;
