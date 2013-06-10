package cn.hit.sqat.info;

public final class Project {

    public static String getTitle() {
        return "Commission";
    }

    public static String getPageTitle(final String page) {
        return page + " / " + getTitle();
    }

    public static String getCopyright() {
        return "&copy; " + getTitle() + " 2013";
    }

    public static int calculateCommission(int total) {
        double commission = 0.1D * Math.min(1000, total);
        if(total <= 1000) return (int)Math.round(commission);
        total -= 1000; commission += 0.15D * Math.min(800, total);
        if(total <= 800) return (int)Math.round(commission);
        total -= 800; commission += 0.20D * total;
        return (int)Math.round(commission);
    }

    public static void main(String[] args) {
        System.out.println(calculateCommission(2500));
    }

    private Project() { throw new AssertionError(); }
}