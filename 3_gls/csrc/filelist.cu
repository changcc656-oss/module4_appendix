PIC_LD=ld

ARCHIVE_OBJS=
ARCHIVE_OBJS += _17650_archive_1.so
_17650_archive_1.so : archive.5/_17650_archive_1.a
	@$(AR) -s $<
	@$(PIC_LD) -shared  -Bsymbolic  -o .//../simv_mc_gate.daidir//_17650_archive_1.so --whole-archive $< --no-whole-archive
	@rm -f $@
	@ln -sf .//../simv_mc_gate.daidir//_17650_archive_1.so $@


ARCHIVE_OBJS += _prev_archive_1.so
_prev_archive_1.so : archive.5/_prev_archive_1.a
	@$(AR) -s $<
	@$(PIC_LD) -shared  -Bsymbolic  -o .//../simv_mc_gate.daidir//_prev_archive_1.so --whole-archive $< --no-whole-archive
	@rm -f $@
	@ln -sf .//../simv_mc_gate.daidir//_prev_archive_1.so $@



VCS_CU_ARC0 =_cuarc0.so

VCS_CU_ARC_OBJS0 =objs/amcQw_d.o 


O0_OBJS =

$(O0_OBJS) : %.o: %.c
	$(CC_CG) $(CFLAGS_O0) -c -o $@ $<


%.o: %.c
	$(CC_CG) $(CFLAGS_CG) -c -o $@ $<

$(VCS_CU_ARC0) : $(VCS_CU_ARC_OBJS0)
	$(PIC_LD) -shared  -Bsymbolic  -o .//../simv_mc_gate.daidir//$(VCS_CU_ARC0) $(VCS_CU_ARC_OBJS0)
	rm -f $(VCS_CU_ARC0)
	@ln -sf .//../simv_mc_gate.daidir//$(VCS_CU_ARC0) $(VCS_CU_ARC0)

CU_UDP_OBJS = \
objs/udps/ZycYe.o objs/udps/Hz6M0.o objs/udps/cfY91.o objs/udps/E3u6e.o objs/udps/c8ZbZ.o  \
objs/udps/YffJQ.o objs/udps/JzzcM.o objs/udps/KQQ1H.o objs/udps/Aw1WF.o objs/udps/Z0bgF.o  \
objs/udps/mTxzr.o objs/udps/BcyNP.o objs/udps/CZfJ6.o objs/udps/u96GI.o objs/udps/mSfbM.o  \
objs/udps/cdUtU.o objs/udps/LSJP2.o objs/udps/Ux6u8.o objs/udps/e37Qb.o objs/udps/K0FAD.o  \
objs/udps/Gjg4Z.o objs/udps/hg6Rm.o objs/udps/Z0GwU.o objs/udps/JgPNT.o objs/udps/pNeY8.o  \
objs/udps/y4a7N.o 

CU_LVL_OBJS = \
SIM_l.o 

MAIN_OBJS = \


CU_OBJS = $(MAIN_OBJS) $(ARCHIVE_OBJS) $(VCS_CU_ARC0) $(CU_UDP_OBJS) $(CU_LVL_OBJS)

